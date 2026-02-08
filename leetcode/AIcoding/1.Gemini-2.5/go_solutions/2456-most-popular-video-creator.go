package main

func mostPopularCreator(creators []string, ids []string, views []int) [][]string {
	creatorTotalViews := make(map[string]int64)
	creatorMaxVideoInfo := make(map[string]struct {
		maxViews int
		videoID  string
	})

	for i := 0; i < len(creators); i++ {
		creator := creators[i]
		id := ids[i]
		view := views[i]

		creatorTotalViews[creator] += int64(view)

		currentMaxVideo, exists := creatorMaxVideoInfo[creator]
		if !exists || view > currentMaxVideo.maxViews {
			creatorMaxVideoInfo[creator] = struct {
				maxViews int
				videoID  string
			}{maxViews: view, videoID: id}
		} else if view == currentMaxVideo.maxViews {
			if id < currentMaxVideo.videoID {
				creatorMaxVideoInfo[creator] = struct {
					maxViews int
					videoID  string
				}{maxViews: view, videoID: id}
			}
		}
	}

	var maxOverallTotalViews int64 = 0
	for _, totalViews := range creatorTotalViews {
		if totalViews > maxOverallTotalViews {
			maxOverallTotalViews = totalViews
		}
	}

	var ans [][]string
	for creator, totalViews := range creatorTotalViews {
		if totalViews == maxOverallTotalViews {
			videoInfo := creatorMaxVideoInfo[creator]
			ans = append(ans, []string{creator, videoInfo.videoID})
		}
	}

	return ans
}