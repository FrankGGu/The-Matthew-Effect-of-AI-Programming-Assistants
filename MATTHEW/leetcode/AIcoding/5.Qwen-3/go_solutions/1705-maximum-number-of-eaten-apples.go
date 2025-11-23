package main

func maxEatenNumber(apple []int, days []int) int {
    n := len(apple)
    type pair struct {
        expDay int
        cnt    int
    }
    heap := []pair{}
    res := 0
    for i := 0; i < n; i++ {
        cnt := apple[i]
        expDay := days[i]
        for cnt > 0 {
            if len(heap) > 0 && heap[0].expDay < i+1 {
                heap = heap[1:]
                continue
            }
            if len(heap) > 0 && heap[0].expDay == i+1 {
                heap[0].cnt++
                heap[0].expDay = i + 1
                break
            }
            if len(heap) > 0 && heap[0].expDay > i+1 {
                heap = append([]pair{{expDay, cnt}}, heap...)
                break
            }
            if len(heap) == 0 {
                heap = append(heap, pair{expDay, cnt})
                break
            }
            cnt--
            res++
        }
    }
    return res
}