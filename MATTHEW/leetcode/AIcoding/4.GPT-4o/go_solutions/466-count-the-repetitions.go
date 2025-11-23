func getMaxRepetitions(s1 string, n1 int, s2 string, n2 int) int {
    len1, len2 := len(s1), len(s2)
    count1, count2 := 0, 0
    index1, index2 := 0, 0
    mapCount := make(map[int]int)

    for count1 < n1 {
        if index1 == len1 {
            count1++
            index1 = 0
        }
        if index2 == len2 {
            count2++
            index2 = 0
        }
        if s1[index1] == s2[index2] {
            index2++
            if index2 == len2 {
                count2++
                index2 = 0
            }
        }
        index1++

        if count1 < n1 {
            if v, ok := mapCount[count1]; ok {
                cycleLength := count1 - v
                cycleCount := (n1 - count1) / cycleLength
                count1 += cycleCount * cycleLength
                count2 += cycleCount * (count2 - mapCount[v])
            } else {
                mapCount[count1] = count2
            }
        }
    }
    return count2 / n2
}