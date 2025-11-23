function validateIPV4(ip) {
    const parts = ip.split('.');
    if (parts.length !== 4) return "Neither";
    for (let part of parts) {
        if (!/^\d+$/.test(part)) return "Neither";
        if (part.length > 1 && part[0] === '0') return "Neither";
        if (parseInt(part, 10) < 0 || parseInt(part, 10) > 255) return "Neither";
    }
    return "IPv4";
}

function validateIPV6(ip) {
    const parts = ip.split(':');
    if (parts.length !== 8) return "Neither";
    const hexChars = "0123456789abcdefABCDEF";
    for (let part of parts) {
        if (part.length < 1 || part.length > 4) return "Neither";
        for (let c of part) {
            if (hexChars.indexOf(c) === -1) return "Neither";
        }
    }
    return "IPv6";
}

function validIPAddress(ip) {
    if (ip.includes('.')) return validateIPV4(ip);
    if (ip.includes(':')) return validateIPV6(ip);
    return "Neither";
}