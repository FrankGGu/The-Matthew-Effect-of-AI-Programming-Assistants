var numUniqueEmails = function(emails) {
    const uniqueEmails = new Set();
    for (const email of emails) {
        const [local, domain] = email.split('@');
        const filteredLocal = local.split('+')[0].replace(/\./g, '');
        uniqueEmails.add(filteredLocal + '@' + domain);
    }
    return uniqueEmails.size;
};