package main

func latestTimeYouCanObtainAfterReplacingCharacters(time string) string {
    timeRunes := []rune(time)
    for i := 0; i < len(timeRunes); i++ {
        if timeRunes[i] == '?' {
            if i == 0 {
                timeRunes[i] = '2'
            } else if i == 1 {
                if timeRunes[0] == '2' {
                    timeRunes[i] = '3'
                } else {
                    timeRunes[i] = '9'
                }
            } else if i == 3 {
                timeRunes[i] = '5'
            } else if i == 4 {
                timeRunes[i] = '9'
            }
        }
    }
    return string(timeRunes)
}