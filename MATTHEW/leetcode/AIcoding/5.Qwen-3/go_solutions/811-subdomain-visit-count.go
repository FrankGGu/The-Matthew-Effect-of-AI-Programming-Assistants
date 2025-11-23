package main

func subdomainVisits(cpdomains []string) []string {
    visits := make(map[string]int)
    for _, domain := range cpdomains {
        parts := strings.Split(domain, " ")
        count, _ := strconv.Atoi(parts[0])
        domains := strings.Split(parts[1], ".")
        for i := 0; i < len(domains); i++ {
            subdomain := strings.Join(domains[i:], ".")
            visits[subdomain] += count
        }
    }
    result := make([]string, 0, len(visits))
    for domain, count := range visits {
        result = append(result, fmt.Sprintf("%d %s", count, domain))
    }
    return result
}