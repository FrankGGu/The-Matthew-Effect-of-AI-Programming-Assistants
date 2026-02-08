import "sort"

func numberOfWeakCharacters(properties [][]int) int {
    sort.Slice(properties, func(i, j int) bool {
        if properties[i][0] == properties[j][0] {
            return properties[i][1] < properties[j][1]
        }
        return properties[i][0] > properties[j][0]
    })

    maxDefense := 0
    res := 0

    for _, prop := range properties {
        if prop[1] < maxDefense {
            res++
        } else {
            maxDefense = prop[1]
        }
    }

    return res
}