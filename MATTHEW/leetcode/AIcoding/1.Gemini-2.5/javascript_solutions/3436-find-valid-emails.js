var numUniqueEmails = function(emails) {
    const uniqueEmails = new Set();

    for (const email of emails) {
        let [local, domain] = email.split('@');

        // Handle '+' character in local name
        const plusIndex = local.indexOf('+');
        if (plusIndex !== -1) {
            local = local.substring(0, plusIndex);
        }

        // Handle '.' character in local name
        local = local.replace(/\./g, '');

        uniqueEmails.add(`${local}@${domain}`);
    }

    return uniqueEmails.size;
};