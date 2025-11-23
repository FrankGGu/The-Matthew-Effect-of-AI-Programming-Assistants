var validIPAddress = function(IP) {
    if (IP.includes('.')) {
        const parts = IP.split('.');
        if (parts.length !== 4) return 'Neither';
        for (const part of parts) {
            if (!/^\d+$/.test(part)) return 'Neither';
            if (part.length > 1 && part[0] === '0') return 'Neither';
            const num = parseInt(part, 10);
            if (isNaN(num) || num < 0 || num > 255) return 'Neither';
        }
        return 'IPv4';
    } else if (IP.includes(':')) {
        const parts = IP.split(':');
        if (parts.length !== 8) return 'Neither';
        for (const part of parts) {
            if (part.length === 0 || part.length > 4) return 'Neither';
            if (!/^[0-9a-fA-F]+$/.test(part)) return 'Neither';
        }
        return 'IPv6';
    } else {
        return 'Neither';
    }
};