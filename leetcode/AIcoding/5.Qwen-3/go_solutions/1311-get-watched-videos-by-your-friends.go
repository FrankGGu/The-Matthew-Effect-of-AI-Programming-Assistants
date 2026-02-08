package main

func watchVideosByFriends(friends [][]int, watchedVideos map[int][]string, id int, minLength int) []string {
    visited := make(map[int]bool)
    queue := []int{id}
    visited[id] = true

    for len(queue) > 0 {
        current := queue[0]
        queue = queue[1:]
        for _, friend := range friends[current] {
            if !visited[friend] {
                visited[friend] = true
                queue = append(queue, friend)
            }
        }
    }

    videoMap := make(map[string]int)
    for friend := range visited {
        for _, video := range watchedVideos[friend] {
            videoMap[video]++
        }
    }

    var result []string
    for video, count := range videoMap {
        if count >= minLength {
            result = append(result, video)
        }
    }

    return result
}