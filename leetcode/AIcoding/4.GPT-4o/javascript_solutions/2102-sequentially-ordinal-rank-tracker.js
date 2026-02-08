class SORTracker {
    constructor() {
        this.users = [];
        this.index = 0;
    }

    add(name, score) {
        this.users.push({ name, score });
        this.users.sort((a, b) => b.score - a.score || a.name.localeCompare(b.name));
    }

    get() {
        return this.users[this.index++].name;
    }
}