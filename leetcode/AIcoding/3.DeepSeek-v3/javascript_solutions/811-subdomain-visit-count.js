var subdomainVisits = function(cpdomains) {
    const countMap = {};

    for (const domain of cpdomains) {
        const [countStr, fullDomain] = domain.split(' ');
        const count = parseInt(countStr, 10);
        const parts = fullDomain.split('.');
        let current = '';

        for (let i = parts.length - 1; i >= 0; i--) {
            current = parts[i] + (current === '' ? '' : '.') + current;
            countMap[current] = (countMap[current] || 0) + count;
        }
    }

    return Object.entries(countMap).map(([domain, count]) => `${count} ${domain}`);
};