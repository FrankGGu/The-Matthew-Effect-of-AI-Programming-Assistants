var subdomainVisits = function(cpdomains) {
    const countMap = new Map();

    for (const cp of cpdomains) {
        const [count, domain] = cp.split(" ");
        const num = parseInt(count);
        const subdomains = domain.split(".");

        for (let i = 0; i < subdomains.length; i++) {
            const subdomain = subdomains.slice(i).join(".");
            countMap.set(subdomain, (countMap.get(subdomain) || 0) + num);
        }
    }

    const result = [];
    for (const [domain, count] of countMap.entries()) {
        result.push(`${count} ${domain}`);
    }

    return result;
};