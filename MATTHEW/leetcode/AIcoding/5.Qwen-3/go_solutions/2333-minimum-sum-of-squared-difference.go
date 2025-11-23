package main

func minSumSquareDifference(targetIndices []int, n int, maxOperations int) int {
    counts := make([]int, n)
    for _, idx := range targetIndices {
        counts[idx]++
    }

    type pair struct {
        val, cnt int
    }

    var pq []pair
    for i := 0; i < n; i++ {
        if counts[i] > 0 {
            pq = append(pq, pair{i, counts[i]})
        }
    }

    sort.Slice(pq, func(i, j int) bool {
        return pq[i].val > pq[j].val
    })

    for maxOperations > 0 {
        if len(pq) == 0 {
            break
        }
        p := pq[0]
        pq = pq[1:]
        if p.cnt == 0 {
            continue
        }
        if p.val == 0 {
            break
        }
        decrease := min(maxOperations, p.cnt)
        maxOperations -= decrease
        newVal := p.val - 1
        if newVal > 0 {
            pq = append(pq, pair{newVal, decrease})
        }
        if p.cnt-decrease > 0 {
            pq = append(pq, pair{p.val, p.cnt - decrease})
        }
        sort.Slice(pq, func(i, j int) bool {
            return pq[i].val > pq[j].val
        })
    }

    res := 0
    for _, p := range pq {
        res += p.val * p.val * p.cnt
    }
    return res
}