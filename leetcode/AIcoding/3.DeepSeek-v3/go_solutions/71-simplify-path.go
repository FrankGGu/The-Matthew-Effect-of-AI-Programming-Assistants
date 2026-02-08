func simplifyPath(path string) string {
    stack := []string{}
    components := strings.Split(path, "/")

    for _, comp := range components {
        if comp == "" || comp == "." {
            continue
        }
        if comp == ".." {
            if len(stack) > 0 {
                stack = stack[:len(stack)-1]
            }
        } else {
            stack = append(stack, comp)
        }
    }

    return "/" + strings.Join(stack, "/")
}