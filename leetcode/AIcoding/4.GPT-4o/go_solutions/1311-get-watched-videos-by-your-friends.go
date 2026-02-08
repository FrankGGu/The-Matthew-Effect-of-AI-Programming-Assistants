package main

import (
	"sort"
)

func watchedVideosByFriends(watchedVideos [][]string, friends [][]int, id int, level int) []string {
	if level == 0 {
		videoCount := make(map[string]int)
		for _, video := range watchedVideos[id] {
			videoCount[video]++
		}
		result := make([]string, 0, len(videoCount))
		for video := range videoCount {
			result = append(result, video)
		}
		sort.Strings(result)
		return result
	}

	visited := make(map[int]bool)
	queue := []int{id}
	visited[id] = true

	for l := 0; l < level; l++ {
		nextQueue := []int{}
		for _, friend := range queue {
			for _, f := range friends[friend] {
				if !visited[f] {
					visited[f] = true
					nextQueue = append(nextQueue, f)
				}
			}
		}
		queue = nextQueue
	}

	videoCount := make(map[string]int)
	for _, friend := range queue {
		for _, video := range watchedVideos[friend] {
			videoCount[video]++
		}
	}

	result := make([]string, 0, len(videoCount))
	for video := range videoCount {
		result = append(result, video)
	}

	sort.Slice(result, func(i, j int) bool {
		if videoCount[result[i]] == videoCount[result[j]] {
			return result[i] < result[j]
		}
		return videoCount[result[i]] < videoCount[result[j]]
	})

	return result
}