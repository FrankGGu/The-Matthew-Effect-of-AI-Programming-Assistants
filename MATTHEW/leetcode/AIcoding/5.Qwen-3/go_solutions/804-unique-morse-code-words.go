package main

func uniqueMorseRepresentations(words []string) int {
    morse := []string{".-","-...","-.-.","-..",".","..-.","--.","....","..",".---","-.-",".-..","--","-.",
                      "---",".--.","--.-",".-.","...","-","..-","...-",".--","-..-","-.--","--.."}
    codeMap := make(map[string]bool)
    for _, word := range words {
        code := ""
        for _, c := range word {
            code += morse[c-'a']
        }
        codeMap[code] = true
    }
    return len(codeMap)
}