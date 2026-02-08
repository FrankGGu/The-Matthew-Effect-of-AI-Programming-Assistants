package main

func destCity(paths [][]string) string {
	departureCities := make(map[string]struct{})

	for _, path := range paths {
		departureCities[path[0]] = struct{}{}
	}

	for _, path := range paths {
		arrivalCity := path[1]
		if _, ok := departureCities[arrivalCity]; !ok {
			return arrivalCity
		}
	}

	return ""
}