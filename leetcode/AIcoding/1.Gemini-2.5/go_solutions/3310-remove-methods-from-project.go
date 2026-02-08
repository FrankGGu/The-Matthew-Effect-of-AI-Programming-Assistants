package main

func removeMethods(methods []string, methodsToRemove []string) []string {
	toRemoveSet := make(map[string]struct{})
	for _, m := range methodsToRemove {
		toRemoveSet[m] = struct{}{}
	}

	var result []string
	for _, m := range methods {
		if _, found := toRemoveSet[m]; !found {
			result = append(result, m)
		}
	}
	return result
}