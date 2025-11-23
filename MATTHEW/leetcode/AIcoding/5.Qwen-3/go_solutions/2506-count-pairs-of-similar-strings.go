package main

func similarPairs(words []string) int {
    count := 0
    for i := 0; i < len(words); i++ {
        setI := make(map[rune]bool)
        for _, c := range words[i] {
            setI[c] = true
        }
        for j := i + 1; j < len(words); j++ {
            setJ := make(map[rune]bool)
            for _, c := range words[j] {
                setJ[c] = true
            }
            if len(setI) == len(setJ) {
                match := true
                for k := range setI {
                    if !setJ[k] {
                        match = false
                        break
                    }
                }
                if match {
                    count++
                }
            }
        }
    }
    return count
}