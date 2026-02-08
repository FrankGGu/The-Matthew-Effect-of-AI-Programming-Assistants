import (
	"strconv"
	"strings"
)

func subdomainVisits(cpdomains []string) []string {
	counts := make(map[string]int)
	for _, cpdomain := range cpdomains {
		parts := strings.Split(cpdomain, " ")
		count, _ := strconv.Atoi(parts[0])
		domain := parts[1]
		domains := strings.Split(domain, ".")
		for i := range domains {
			subdomain := strings.Join(domains[i:], ".")
			counts[subdomain] += count
		}
	}

	result := make([]string, 0)
	for domain, count := range counts {
		result = append(result, strconv.Itoa(count)+" "+domain)
	}
	return result
}