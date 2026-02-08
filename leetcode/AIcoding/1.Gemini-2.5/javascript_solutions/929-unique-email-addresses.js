var numUniqueEmails = function(emails) {
    const uniqueEmails = new Set();

    for (const email of emails) {
        let [localName, domainName] = email.split('@');

        const plusIndex = localName.indexOf('+');
        if (plusIndex !== -1) {
            localName = localName.substring(0, plusIndex);
        }

        localName = localName.replace(/\./g, '');

        uniqueEmails.add(`${localName}@${domainName}`);
    }

    return uniqueEmails.size;
};