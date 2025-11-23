package main

import (
	"sort"
)

type Video struct {
	creator string
	views   int
}

func mostPopularCreator(creators []string, ids []string, views []int) [][]string {
	videoMap := make(map[string]*Video)
	creatorMap := make(map[string]int)

	for i := range creators {
		creatorMap[creators[i]] += views[i]
		if _, exists := videoMap[creators[i]]; !exists || videoMap[creators[i]].views < views[i] {
			videoMap[creators[i]] = &Video{creators[i], views[i]}
		}
	}

	type creatorViews struct {
		name  string
		total int
	}

	var creatorList []creatorViews
	for name, total := range creatorMap {
		creatorList = append(creatorList, creatorViews{name, total})
	}

	sort.Slice(creatorList, func(i, j int) bool {
		if creatorList[i].total == creatorList[j].total {
			return creatorList[i].name < creatorList[j].name
		}
		return creatorList[i].total > creatorList[j].total
	})

	var result [][]string
	maxViews := creatorList[0].total
	for _, creator := range creatorList {
		if creator.total < maxViews {
			break
		}
		videos := []string{}
		for _, video := range videoMap {
			if video.creator == creator.name {
				videos = append(videos, video.creator)
			}
		}
		if len(videos) > 0 {
			result = append(result, []string{creator.name, videos[0]})
		}
	}

	return result
}