func getMaxRepetitions(s1 string, n1 int, s2 string, n2 int) int {
    len1, len2 := len(s1), len(s2)
    s1Cnt, s2Cnt := 0, 0
    p := 0
    record := make(map[int][2]int)

    for s1Cnt < n1 {
        for i := 0; i < len1; i++ {
            if s1[i] == s2[p] {
                p++
                if p == len2 {
                    p = 0
                    s2Cnt++
                }
            }
        }
        s1Cnt++

        if _, exists := record[p]; exists {
            s1CntPrev, s2CntPrev := record[p][0], record[p][1]
            loopS1 := s1Cnt - s1CntPrev
            loopS2 := s2Cnt - s2CntPrev
            remainingLoops := (n1 - s1CntPrev) / loopS1
            s1Cnt += remainingLoops * loopS1
            s2Cnt += remainingLoops * loopS2
        } else {
            record[p] = [2]int{s1Cnt, s2Cnt}
        }
    }

    return s2Cnt / n2
}