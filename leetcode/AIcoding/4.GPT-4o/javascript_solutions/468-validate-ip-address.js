var validIPAddress = function(IP) {
    const isIPv4 = (ip) => {
        const parts = ip.split('.');
        if (parts.length !== 4) return false;
        for (let part of parts) {
            if (!/^\d{1,3}$/.test(part) || (part[0] === '0' && part.length > 1) || +part > 255) {
                return false;
            }
        }
        return true;
    };

    const isIPv6 = (ip) => {
        const parts = ip.split(':');
        if (parts.length !== 8) return false;
        for (let part of parts) {
            if (!/^[0-9a-fA-F]{1,4}$/.test(part)) {
                return false;
            }
        }
        return true;
    };

    if (IP.includes('.')) {
        return isIPv4(IP) ? "IPv4" : "Neither";
    } else if (IP.includes(':')) {
        return isIPv6(IP) ? "IPv6" : "Neither";
    }
    return "Neither";
};