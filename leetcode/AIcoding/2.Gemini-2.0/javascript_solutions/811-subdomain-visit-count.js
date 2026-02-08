var subdomainVisits = function(cpdomains) {
    const counts = {};
    for (const cpdomain of cpdomains) {
        const [count, domain] = cpdomain.split(" ");
        const countNum = parseInt(count);
        const parts = domain.split(".");
        let currentDomain = "";
        for (let i = parts.length - 1; i >= 0; i--) {
            currentDomain = parts[i] + (currentDomain ? "." + currentDomain : "");
            counts[currentDomain] = (counts[currentDomain] || 0) + countNum;
        }
    }
    const result = [];
    for (const domain in counts) {
        result.push(`${counts[domain]} ${domain}`);
    }
    return result;
};