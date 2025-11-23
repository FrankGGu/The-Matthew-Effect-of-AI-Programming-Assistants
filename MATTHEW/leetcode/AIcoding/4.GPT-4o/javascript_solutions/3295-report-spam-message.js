function checkSpam(messages) {
    return messages.map(message => {
        const lowerCaseMessage = message.toLowerCase();
        return lowerCaseMessage.includes('spam') || lowerCaseMessage.includes('advertisement') ? 'spam' : 'not spam';
    });
}