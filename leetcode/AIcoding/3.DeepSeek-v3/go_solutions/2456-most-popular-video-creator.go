func mostPopularCreator(creators []string, ids []string, views []int) [][]string {
    creatorPopularity := make(map[string]int)
    creatorVideos := make(map[string][]struct {
        id    string
        views int
    })

    maxPopularity := 0

    for i := 0; i < len(creators); i++ {
        creator := creators[i]
        view := views[i]
        id := ids[i]

        creatorPopularity[creator] += view
        if creatorPopularity[creator] > maxPopularity {
            maxPopularity = creatorPopularity[creator]
        }

        creatorVideos[creator] = append(creatorVideos[creator], struct {
            id    string
            views int
        }{id, view})
    }

    var result [][]string

    for creator, popularity := range creatorPopularity {
        if popularity == maxPopularity {
            videos := creatorVideos[creator]
            maxView := -1
            var selectedID string

            for _, video := range videos {
                if video.views > maxView || (video.views == maxView && (selectedID == "" || video.id < selectedID)) {
                    maxView = video.views
                    selectedID = video.id
                }
            }

            result = append(result, []string{creator, selectedID})
        }
    }

    return result
}