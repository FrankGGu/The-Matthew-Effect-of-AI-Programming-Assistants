func subdomainVisits(cpdomains []string) []string {
    domainCount := make(map[string]int)

    for _, domain := range cpdomains {
        parts := strings.Split(domain, " ")
        count, _ := strconv.Atoi(parts[0])
        subdomains := strings.Split(parts[1], ".")

        current := ""
        for i := len(subdomains) - 1; i >= 0; i-- {
            if current == "" {
                current = subdomains[i]
            } else {
                current = subdomains[i] + "." + current
            }
            domainCount[current] += count
        }
    }

    result := make([]string, 0, len(domainCount))
    for domain, count := range domainCount {
        result = append(result, fmt.Sprintf("%d %s", count, domain))
    }

    return result
}