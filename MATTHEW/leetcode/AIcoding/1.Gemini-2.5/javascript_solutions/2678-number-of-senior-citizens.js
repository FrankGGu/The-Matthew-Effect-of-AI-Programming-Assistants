var countSeniors = function(details) {
    let seniorCitizensCount = 0;
    for (let i = 0; i < details.length; i++) {
        const ageString = details[i].substring(11, 13);
        const age = parseInt(ageString);
        if (age > 60) {
            seniorCitizensCount++;
        }
    }
    return seniorCitizensCount;
};