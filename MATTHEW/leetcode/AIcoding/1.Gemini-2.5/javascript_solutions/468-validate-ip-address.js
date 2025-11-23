function validIPAddress(IP) {
    function isValidIPv4(s) {
        const parts = s.split('.');
        if (parts.length !== 4) {
            return false;
        }

        for (const part of parts) {
            if (part.length === 0 || part.length > 3) {
                return false;
            }
            if (part.length > 1 && part[0] === '0') {
                return false;
            }
            for (let i = 0; i < part.length; i++) {
                const charCode = part.charCodeAt(i);
                if (charCode < 48 || charCode > 57) {
                    return false;
                }
            }
            const num = parseInt(part, 10);
            if (isNaN(num) || num < 0 || num > 255) {
                return false;
            }
        }
        return true;
    }

    function isValidIPv6(s) {
        const parts = s.split(':');
        if (parts.length !== 8) {
            return false;
        }

        const hexChars = "0123456789abcdefABCDEF";

        for (const part of parts) {
            if (part.length === 0 || part.length > 4) {
                return false;
            }
            for (let i = 0; i < part.length; i++) {
                if (!hexChars.includes(part[i])) {
                    return false;
                }
            }
        }
        return true;
    }

    if (IP.includes('.')) {
        if (isValidIPv4(IP)) {
            return "IPv4";
        }
    } else if (IP.includes(':')) {
        if (isValidIPv6(IP)) {
            return "IPv6";
        }
    }

    return "Neither";
}