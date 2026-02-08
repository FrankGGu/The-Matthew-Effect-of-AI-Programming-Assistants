func dynamicPassword(password string, k int) string {
    if k >= len(password) {
        return password
    }
    return password[k:] + password[:k]
}