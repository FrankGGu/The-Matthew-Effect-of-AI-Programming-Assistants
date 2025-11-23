package main

func largestValuesFromLabels(labelList []int, valueList []int, numWanted int, limit int) int {
    type item struct {
        label int
        value int
    }
    items := make([]item, len(labelList))
    for i := range labelList {
        items[i] = item{labelList[i], valueList[i]}
    }

    sort.Slice(items, func(i, j int) bool {
        return items[i].value > items[j].value
    })

    count := make(map[int]int)
    result := 0
    selected := 0

    for _, item := range items {
        if selected >= numWanted {
            break
        }
        if count[item.label] < limit {
            result += item.value
            count[item.label]++
            selected++
        }
    }

    return result
}