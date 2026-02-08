var numUniqueEmails = function(emails) {
    const uniqueEmails = new Set();

    for (const email of emails) {
        const [local, domain] = email.split('@');
        let cleanedLocal = '';
        for (let i = 0; i < local.length; i++) {
            if (local[i] === '+') {
                break;
            }
            if (local[i] !== '.') {
                cleanedLocal += local[i];
            }
        }
        uniqueEmails.add(cleanedLocal + '@' + domain);
    }

    return uniqueEmails.size;
};