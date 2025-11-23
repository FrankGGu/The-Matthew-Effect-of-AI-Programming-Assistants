func twoEditWords(queries []string, dictionary []string) []string {
    result := []string{}

    for _, query := range queries {
        foundMatch := false
        for _, dictWord := range dictionary {
            diffCount := 0
            // All words have the same length as per problem description
            wordLength := len(query) 

            for i := 0; i < wordLength; i++ {
                if query[i] != dictWord[i] {
                    diffCount++
                }
                // Optimization: if diffCount exceeds 2, this dictWord is not a match
                if diffCount > 2 {
                    break 
                }
            }

            if diffCount <= 2 {
                result = append(result, query)
                foundMatch = true
                break // Found a suitable dictionary word for this query, move to the next query
            }
        }
    }

    return result
}