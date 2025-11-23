func checkOnesSegment(s string) bool {
    return strings.Count(s, "1") <= 1 || strings.Index(s, "01") == -1
}