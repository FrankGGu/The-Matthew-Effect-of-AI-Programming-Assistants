import (
	"strconv"
	"strings"
)

func subdomainVisits(cpdomains []string) []string {
	counts := make(map[string]int)

	for _, cpdomain := range cpdomains {
		spaceIdx := strings.IndexByte(cpdomain, ' ')
		count, _ := strconv.Atoi(cpdomain[:spaceIdx])
		fullDomain := cpdomain[spaceIdx+1:]

		counts[fullDomain] += count

		for i := 0; i < len(fullDomain); i++ {
			if fullDomain[i] == '.' {
				subdomain := fullDomain[i+1:]
				counts[subdomain] += count
			}
		}
	}

	result := make([]string, 0, len(counts))
	for domain, count := range counts {
		result = append(result, strconv.Itoa(count)+" "+domain)
	}

	return result
}