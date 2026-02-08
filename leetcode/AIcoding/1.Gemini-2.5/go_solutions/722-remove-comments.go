func removeComments(source []string) []string {
    result := []string{}
    blockCommentMode := false
    currentLineBuffer := []rune{}

    for _, line := range source {
        for i := 0; i < len(line); {
            if blockCommentMode {
                if i+1 < len(line)