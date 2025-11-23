var numUniqueEmails = function(emails) {
    const uniqueEmails = new Set();
    for (const email of emails) {
        const [local, domain] = email.split('@');
        const processedLocal = local.split('+')[0].replace(/\./g, '');
        uniqueEmails.add(`${processedLocal}@${domain}`);
    }
    return uniqueEmails.size;
};