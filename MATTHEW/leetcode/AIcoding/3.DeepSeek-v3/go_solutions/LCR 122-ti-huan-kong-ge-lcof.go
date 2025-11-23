func pathEncryption(path string) string {
    return strings.ReplaceAll(path, ".", " ")
}