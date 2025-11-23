func watchedVideosByFriends(watchedVideos [][]string, friends [][]int, id int, level int) []string {
    visited := make([]bool, len(friends))
    queue := []int{id}
    visited[id] = true
    currentLevel := 0

    for len(queue) > 0 && currentLevel < level {
        size := len(queue)
        for i := 0; i < size; i++ {
            current := queue[0]
            queue = queue[1:]
            for _, friend := range friends[current] {
                if !visited[friend] {
                    visited[friend] = true
                    queue = append(queue, friend)
                }
            }
        }
        currentLevel++
    }

    videoCount := make(map[string]int)
    for _, friend := range queue {
        for _, video := range watchedVideos[friend] {
            videoCount[video]++
        }
    }

    videos := make([]string, 0, len(videoCount))
    for video := range videoCount {
        videos = append(videos, video)
    }

    sort.Slice(videos, func(i, j int) bool {
        if videoCount[videos[i]] == videoCount[videos[j]] {
            return videos[i] < videos[j]
        }
        return videoCount[videos[i]] < videoCount[videos[j]]
    })

    return videos
}