package main

func getHint(secret string, guess string) string {
    var bulls, cows int
    freq := make([]int, 10)
    for i := 0; i < len(secret); i++ {
        s := secret[i] - '0'
        g := guess[i] - '0'
        if s == g {
            bulls++
        } else {
            freq[s]++
            freq[g]++
        }
    }
    for i := 0; i < 10; i++ {
        cows += freq[i] / 2
    }
    return fmt.Sprintf("%d Bull%s, %d Cow%s", bulls, plural(bulls), cows, plural(cows))
}

func plural(n int) string {
    if n == 1 {
        return ""
    }
    return "s"
}