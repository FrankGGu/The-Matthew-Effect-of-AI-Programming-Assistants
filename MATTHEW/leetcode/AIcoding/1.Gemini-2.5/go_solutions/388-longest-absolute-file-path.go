package solution

import (
	"strings"
)

func longestAbsoluteFilePath(input string) int {
	if len(input) == 0 {
		return 0
	}

	lines := strings.Split(input, "\n")
	// pathLengths[i] stores the total length of the path up to the directory at depth i.
	// This length includes the name of the directory at depth i and the '/' separator
	// that connects it to its parent, but not a trailing '/' for itself.
	// For example, if path is "dir/subdir", pathLengths[0] would be len("dir"),
	// and pathLengths[1] would be len("dir") + 1 (for '/') + len("subdir").
	// The maximum possible depth is len(lines).
	pathLengths := make([]int, len(lines)+1)

	maxLength := 0

	for _, line := range lines {
		// Calculate depth by counting leading tabs and extract the actual name.
		depth := 0
		firstCharIndex := 0
		for firstCharIndex < len(line) && line[firstCharIndex] == '\t' {
			depth++
			firstCharIndex++
		}
		name := line[firstCharIndex:]

		isFile := strings.Contains(name, ".")
		currentNameLength := len(name)

		if isFile {
			// If it's a file, calculate its full absolute path length.
			// The length of the path up to its parent directory is pathLengths[depth-1].
			// We add the current file's name length and 1 for the '/' separator.
			currentFullPathLength := 0
			if depth > 0 {
				// Parent path length + '/' + file name length
				currentFullPathLength = pathLengths[depth-1] + 1 + currentNameLength
			} else {
				// File at root level, no parent directory or separator
				currentFullPathLength = currentNameLength
			}
			if currentFullPathLength > maxLength {
				maxLength = currentFullPathLength
			}
		} else {
			// If it's a directory, update pathLengths for this depth.
			// This path will serve as the parent for subsequent entries at depth+1.
			if depth > 0 {
				// Parent path length + '/' + current directory name length
				pathLengths[depth] = pathLengths[depth-1] + 1 + currentNameLength
			} else {
				// Top-level directory, just its name length
				pathLengths[depth] = currentNameLength
			}
		}
	}

	return maxLength
}