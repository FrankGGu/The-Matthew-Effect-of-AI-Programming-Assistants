function invalidIPAddresses(IPs) {
    const isValid = (ip) => {
        const parts = ip.split('.');
        if (parts.length !== 4) return false;
        for (const part of parts) {
            if (part.length === 0 || part.length > 3 || (part[0] === '0' && part.length > 1) || isNaN(part) || Number(part) < 0 || Number(part) > 255) {
                return false;
            }
        }
        return true;
    };

    return IPs.filter(ip => !isValid(ip));
}