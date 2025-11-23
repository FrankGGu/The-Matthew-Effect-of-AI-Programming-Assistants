import (
	"strings"
)

func simplifyPath(path string) string {
	stack := []string{}
	parts := strings.Split(path, "/")

	for _, part := range parts {
		if part == "" || part == "." {
			continue
		} else if part == ".." {
			if len(stack) > 0 {
				stack = stack[:len(stack)-1]
			}
		} else {
			stack = append(stack, part)
		}
	}

	if len(stack) == 0 {
		return "/"
	}

	return "/" + strings.Join(stack, "/")
}