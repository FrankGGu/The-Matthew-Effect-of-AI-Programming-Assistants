var numUniqueEmails = function(emails) {
    const uniqueEmails = new Set();

    for (const email of emails) {
        const [local, domain] = email.split('@');
        const sanitizedLocal = local.split('+')[0].replace(/\./g, '');
        uniqueEmails.add(sanitizedLocal + '@' + domain);
    }

    return uniqueEmails.size;
};