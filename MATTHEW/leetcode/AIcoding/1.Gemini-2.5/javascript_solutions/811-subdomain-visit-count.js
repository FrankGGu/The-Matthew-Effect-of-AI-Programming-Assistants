var subdomainVisits = function(cpdomains) {
    const counts = new Map();

    for (const cpdomain of cpdomains) {
        const parts = cpdomain.split(' ');
        const count = parseInt(parts[0], 10);
        let domain = parts[1];

        let currentDomain = domain;
        while (true) {
            counts.set(currentDomain, (counts.get(currentDomain) || 0) + count);

            const dotIndex = currentDomain.indexOf('.');
            if (dotIndex === -1) {
                break;
            }
            currentDomain = currentDomain.substring(dotIndex + 1);
        }
    }

    const result = [];
    for (const [domain, count] of counts.entries()) {
        result.push(`${count} ${domain}`);
    }

    return result;
};