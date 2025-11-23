func checkStrings(s1 string, s2 string) bool {
    n := len(s1)

    s1EvenFreq := [26]int{}
    s1OddFreq := [26]int{}
    s2EvenFreq := [26]int{}
    s2OddFreq := [26]int{}

    for i := 0; i < n; i++ {
        if i%2 == 0 { // Even index
            s1EvenFreq[s1[i]-'a']++
            s2EvenFreq[s2[i]-'a']++
        } else { // Odd index
            s1OddFreq[s1[i]-'a']++
            s2OddFreq[s2[i]-'a']++
        }
    }

    return s1EvenFreq == s2EvenFreq && s1OddFreq == s2OddFreq
}