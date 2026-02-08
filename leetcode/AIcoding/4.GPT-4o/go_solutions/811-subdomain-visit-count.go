package main

import (
	"fmt"
	"strings"
)

func subdomainVisits(cpdomains []string) []string {
	counts := make(map[string]int)

	for _, cpdomain := range cpdomains {
		parts := strings.Split(cpdomain, " ")
		count := parts[0]
		domain := parts[1]
		countInt := 0
		fmt.Sscanf(count, "%d", &countInt)

		subdomains := strings.Split(domain, ".")
		for i := 0; i < len(subdomains); i++ {
			subdomain := strings.Join(subdomains[i:], ".")
			counts[subdomain] += countInt
		}
	}

	result := []string{}
	for domain, count := range counts {
		result = append(result, fmt.Sprintf("%d %s", count, domain))
	}
	return result
}