func watchedVideosByFriends(watchedVideos [][]string, friends [][]int, id int, level int) []string {
    n := len(friends)
    visited := make([]bool, n)
    visited[id] = true
    queue := []int{id}
    for i := 0; i < level; i++ {
        nextQueue := []int{}
        for _, u := range queue {
            for _, v := range friends[u] {
                if !visited[v] {
                    visited[v] = true
                    nextQueue = append(nextQueue, v)
                }
            }
        }
        queue = nextQueue
    }

    videoMap := make(map[string]int)
    for _, u := range queue {
        for _, video := range watchedVideos[u] {
            videoMap[video]++
        }
    }

    type VideoCount struct {
        Video string
        Count int
    }

    videoCounts := []VideoCount{}
    for video, count := range videoMap {
        videoCounts = append(videoCounts, VideoCount{Video: video, Count: count})
    }

    sort.Slice(videoCounts, func(i, j int) bool {
        if videoCounts[i].Count != videoCounts[j].Count {
            return videoCounts[i].Count < videoCounts[j].Count
        }
        return videoCounts[i].Video < videoCounts[j].Video
    })

    result := []string{}
    for _, vc := range videoCounts {
        result = append(result, vc.Video)
    }

    return result
}