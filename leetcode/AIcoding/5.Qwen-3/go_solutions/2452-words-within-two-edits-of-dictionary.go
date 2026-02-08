package main

func twoEditWords(queries []string, dictionary []string) []string {
    result := make([]string, 0)
    for _, q := range queries {
        for _, d := range dictionary {
            diff := 0
            for i := 0; i < len(q) && i < len(d); i++ {
                if q[i] != d[i] {
                    diff++
                    if diff > 2 {
                        break
                    }
                }
            }
            if diff <= 2 {
                result = append(result, q)
                break
            }
        }
    }
    return result
}