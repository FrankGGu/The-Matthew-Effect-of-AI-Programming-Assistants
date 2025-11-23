package main

func closestRoom(rooms [][]int, requests []int) []int {
    sort.Slice(rooms, func(i, j int) bool {
        return rooms[i][0] < rooms[j][0]
    })
    n := len(rooms)
    m := len(requests)
    res := make([]int, m)
    type request struct {
        idx  int
        size int
    }
    requestsWithIdx := make([]request, m)
    for i := range requests {
        requestsWithIdx[i] = request{i, requests[i]}
    }
    sort.Slice(requestsWithIdx, func(i, j int) bool {
        return requestsWithIdx[i].size < requestsWithIdx[j].size
    })
    k := 0
    for _, req := range requestsWithIdx {
        for k < n && rooms[k][0] <= req.size {
            k++
        }
        if k == 0 {
            res[req.idx] = -1
        } else {
            minDist := math.MaxInt32
            bestID := -1
            for i := 0; i < k; i++ {
                dist := abs(rooms[i][1] - req.size)
                if dist < minDist || (dist == minDist && rooms[i][0] < bestID) {
                    minDist = dist
                    bestID = rooms[i][0]
                }
            }
            res[req.idx] = bestID
        }
    }
    return res
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}