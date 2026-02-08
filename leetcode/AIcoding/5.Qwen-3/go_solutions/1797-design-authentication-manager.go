package main

type AuthenticationManager struct {
    tokenExpiry map[string]int
    currentTime   int
}

func Constructor() AuthenticationManager {
    return AuthenticationManager{
        tokenExpiry: make(map[string]int),
        currentTime: 0,
    }
}

func (this *AuthenticationManager) Generate(tokenId string, expirationTime int) {
    this.tokenExpiry[tokenId] = expirationTime
}

func (this *AuthenticationManager) Renew(tokenId string, newExpirationTime int) {
    if expiry, exists := this.tokenExpiry[tokenId]; exists && expiry > this.currentTime {
        this.tokenExpiry[tokenId] = newExpirationTime
    }
}

func (this *AuthenticationManager) CountUnexpiredTokens() int {
    count := 0
    for tokenId, expiry := range this.tokenExpiry {
        if expiry > this.currentTime {
            count++
        }
    }
    return count
}

func (this *AuthenticationManager) SetTime(time int) {
    this.currentTime = time
}