function minPeopleToTeach(people, languages, friendships) {
    const languageSet = new Set(languages);
    const personLanguage = new Map();
    for (let i = 0; i < people.length; i++) {
        personLanguage.set(people[i], new Set(languages[i]));
    }

    const teach = new Set();
    for (const [u, v] of friendships) {
        const uLang = personLanguage.get(u);
        const vLang = personLanguage.get(v);
        let hasCommon = false;
        for (const lang of uLang) {
            if (vLang.has(lang)) {
                hasCommon = true;
                break;
            }
        }
        if (!hasCommon) {
            teach.add(u);
            teach.add(v);
        }
    }

    return teach.size;
}