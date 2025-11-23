func maximumNetworkQuality(servers [][]int, k int) []int {
    n := len(servers)
    sort.Slice(servers, func(i, j int) bool {
        if servers[i][2] == servers[j][2] {
            return servers[i][0] < servers[j][0]
        }
        return servers[i][2] > servers[j][2]
    })

    maxQuality := 0
    bestCoord := []int{}

    for i := 0; i < n; i++ {
        if servers[i][1] > 0 {
            quality := servers[i][2]
            coord := []int{servers[i][0], servers[i][1]}
            cnt := 1
            for j := i + 1; j < n && cnt < k; j++ {
                if servers[j][1] > 0 {
                    quality += servers[j][2]
                    coord[0] += servers[j][0]
                    coord[1] += servers[j][1]
                    cnt++
                }
            }
            if cnt == k && quality > maxQuality {
                maxQuality = quality
                bestCoord = coord
            }
        }
    }

    return bestCoord
}