package main

func findDuplicates(files []string) []string {
    seen := make(map[string]bool)
    result := []string{}

    for _, file := range files {
        if seen[file] {
            result = append(result, file)
        } else {
            seen[file] = true
        }
    }

    return result
}