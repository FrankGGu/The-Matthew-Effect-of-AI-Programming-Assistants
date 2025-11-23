func findRepeatedDnaSequences(s string) []string {
    if len(s) < 10 {
        return []string{}
    }

    // Map characters to 2-bit integers
    // A: 00 (0)
    // C: 01 (1)
    //