func removeMethods(modules [][]string, methods []string) []string {
	moduleSet := make(map[string]bool)
	for _, module := range modules {
		moduleSet[module[0]] = true
	}

	methodSet := make(map[string]bool)
	for _, method := range methods {
		methodSet[method] = true
	}

	result := []string{}
	for moduleName := range moduleSet {
		valid := true
		for _, module := range modules {
			if module[0] == moduleName {
				if _, ok := methodSet[module[1]]; ok {
					valid = false
					break
				}
			}
		}
		if valid {
			result = append(result, moduleName)
		}
	}

	return result
}